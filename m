From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 8 Sep 2011 09:20:12 +0530
Subject: [PATCH 16/18] dmaengine/amba-pl08x: Add support for sg len greater
	than one for slave transfers
In-Reply-To: <CAKnu2Mp3Ui7jZS2kjJykjuzcTzJhiAkoaVxZ2+tQX0banGh6mw@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
	<20110814083618.GE4986@n2100.arm.linux.org.uk>	<4E4CCF7B.8060704@st.com>
	<20110821083306.GA12028@n2100.arm.linux.org.uk>	<4E532B19.6000103@st.com>
	<4E5715CE.2070806@st.com>
	<CACRpkdapSvW=eMSoXTOOA2GyhfBLzq2OuyQcDctPxsnVzvr-4g@mail.gmail.com>
	<4E575E75.40603@st.com>	<4E5F594D.10203@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A4C@bgsmsx502.gar.corp.intel.com>
	<CAKnu2Mp3Ui7jZS2kjJykjuzcTzJhiAkoaVxZ2+tQX0banGh6mw@mail.gmail.com>
Message-ID: <4E683B74.5000701@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/8/2011 4:31 AM, Linus Walleij wrote:
> I think the patch brings valuable functionality we don't want to loose when
> there is a solution. Basically the dmaengine has a contract to handle
> sglists of any lengths and it's a pity that we don't, and I suspect Viresh
> cannot use the driver for MMC unless something like this is added, so
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 

Thanks Again.

> BUT I think it is possible to rewrite it a bit later so as to get a better
> handling of this. Isn't Russells initial remark that the LLI:s can simply just
> take in the entire sglist at once true?

If i am getting this clearly, the concern is "why to queue separate transfers for
individual sg's? Better would be to prepare the complete list at once and
start the transfer, so that DMA stops only after finishing all sg's
passed from user." Is this what you are pointing at?

If yes, then the same is done in this patch too. An array for llis is allocated at 
the start, then for each sg i prepare lli list from this array. Last lli from one sg
is followed by first lli from next sg. And so i get a continuous chain of llis.

-- 
viresh
