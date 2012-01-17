From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Jan 2012 14:49:53 +0530
Subject: [PATCH 8/8] dmaengine/dw_dmac: Add support for DMA_SLAVE_CONFIG
In-Reply-To: <4F153C33.5060805@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <7c1e6fd573d5cd348b22f8363c9960fe5efcd658.1326707233.git.viresh.kumar@st.com>
 <4F140D25.1000309@st.com>
 <CACRpkdbY7ZOwY6GR4t+GODYL4yAdH-PXExmwp84R+Gz2W19X7w@mail.gmail.com>
 <4F153C33.5060805@st.com>
Message-ID: <4F153D39.50206@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/17/2012 2:45 PM, Viresh Kumar wrote:
>>>>>> >>> >> +      * Fix sconfig's burst size according to dw_dmac. We need to convert
>>>>>> >>> >> +      * them as: 1 -> 0, 2 -> 1, 4 -> 2, 8 -> 3, 16 -> 4.
> I need above conversion. i.e. finding bit no. of first bit set.

Something like:

unsigned int v; // 32-bit word
unsigned int r = 0;

while (v >>= 1)
{
  r++;
}

Probably find_first_bit() suits it.

-- 
viresh
