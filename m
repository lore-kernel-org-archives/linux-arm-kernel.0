From: briannorris@chromium.org (Brian Norris)
Date: Thu, 25 Jan 2018 14:51:00 -0800
Subject: [PATCH v1 1/2] drm/bridge/synopsys: dsi: Fix dsi_host_transfer()
 return value
In-Reply-To: <61a3e22a-811b-53e5-f735-534dfd9f67da@samsung.com>
References: <20180123142618.28384-1-philippe.cornu@st.com>
 <20180123142618.28384-2-philippe.cornu@st.com>
 <CA+ASDXNDpmVdARLCD-A6nfADgmomuscpwekb8M-j=MFJhpeC4Q@mail.gmail.com>
 <4a1b0208-3187-2f08-69fe-ca3b77ee88a8@st.com>
 <CGME20180124183757epcas5p2e8296b5712fc0f2004eb81111693e166@epcas5p2.samsung.com>
 <20180124183748.l5iqoiyqxy4o2pyk@ban.mtv.corp.google.com>
 <61a3e22a-811b-53e5-f735-534dfd9f67da@samsung.com>
Message-ID: <CA+ASDXOXBV0gUrKMb9W2M5EGLUBLjDp4L1qRhnyor04cnS7AsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 4:16 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 24.01.2018 19:37, Brian Norris wrote:
>> With your current patch, you're returning the 'mipi_dsi_packet::size',
>> which is the sum of both TX and RX.
>
> I did not found docs saying mipi_dsi_packet::size is a sum of tx and rx.
> tx and rx packets are two different packets, so they do not sum up.
> But thanks for bringing it up, it shows docs are incomplete/misleading.

Ugh, I misread that again. No, mipi_dsi_packet::size is NOT claimed to
contain both TX and RX. It just says "size of the packet", and packet
clearly does not hold the RX data anyway. I don't know what's
happening to my reading comprehension...

But the mismatch on whether drivers implement these correctly and
whether any callers actually care about the documented semantics still
stands.

Brian
