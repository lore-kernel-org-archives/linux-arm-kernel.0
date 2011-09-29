From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 29 Sep 2011 09:52:56 +0530
Subject: [PATCH V2 1/1] dmaengine/amba-pl08x: Add support for s3c64xx DMAC
In-Reply-To: <CAGOxZ535KHUp6An2br0scU9HvCmg4OsnfCj7hWYq4iy+OEpO2Q@mail.gmail.com>
References: <1317189007-23033-1-git-send-email-alim.akhtar@samsung.com>
	<1317189007-23033-2-git-send-email-alim.akhtar@samsung.com>
	<4E82D0A1.8050203@st.com>
	<CAGOxZ53qZy+VUM65oK68W088QR=RgQ=cNxOCbO7_WESJesJaVQ@mail.gmail.com>
	<4E82EEE1.3020706@st.com>
	<CAGOxZ535KHUp6An2br0scU9HvCmg4OsnfCj7hWYq4iy+OEpO2Q@mail.gmail.com>
Message-ID: <4E83F2A0.3090501@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/28/2011 5:24 PM, Alim Akhtar wrote:
> I did Modified pl08x_cctl_bits(), but for some reason i reverted it back.
> what i was doing something like returning just __retbits__ instead of
> retbits |= tsize << PL080_CONTROL_TRANSFER_SIZE_SHIFT;
> and doing the below for the __non-s3c__ controllers in the
> pl08x_fill_lli_for_desc().
> cctl |= 1 << PL080_CONTROL_TRANSFER_SIZE_SHIFT;
> pl08x_fill_lli_for_desc(&bd, num_llis++, 1, cctl);
> 

One way out would be:
Don't do retbits |= tsize << PL080_CONTROL_TRANSFER_SIZE_SHIFT in
pl08x_cctl_bits() and do this conditionally in pl08x_fill_lli_for_desc().
This needs adding tsize argument in fill_lli_**() routine and removing it
from cctl_bits().

Probably this is what you were mentioning.

-- 
viresh
