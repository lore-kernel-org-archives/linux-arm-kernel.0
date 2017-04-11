From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Apr 2017 22:10:40 +0100
Subject: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
In-Reply-To: <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
Message-ID: <20170411211040.htrcedus3c57fbed@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 03:44:52PM +0000, Olivier MOYSAN wrote:

> However, regarding STM32 I2S driver, I'm wondering if selecting DAI
> is the best way to configure interface as tx, rx or fd.

Why do you even need to configure this?

> Maybe, it is more relevant to configure DAI according to DMA
> configuration from I2S node.
> This would moreover avoid to allocate 2 dmas channels when not
> necessary (tx or rx only).
> If you agree with this, I will implement this change in a v2.

That sounds wrong, I'd expect this wiring to be done statically as part
of the .dtsi for the SoC (or just grabbed as needed at runtime if
things are flexbile enough) rather than being a configuration thing done
per board...  I had thought that this was configuration reflecting
different ways of taping out the IP with different feature sets, is that
not the case?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170411/1dcedbfa/attachment.sig>
