From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Apr 2017 16:38:31 +0100
Subject: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
In-Reply-To: <d886a9c7-ca46-f37a-0e82-6ed8d7a4e052@st.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
 <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
 <20170412113251.nfyk5sw6c5pnpmwr@sirena.org.uk>
 <d886a9c7-ca46-f37a-0e82-6ed8d7a4e052@st.com>
Message-ID: <20170412153831.r2urwvfseipfsrsi@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 12:58:16PM +0000, Olivier MOYSAN wrote:
> On 04/12/2017 01:32 PM, Mark Brown wrote:

> > It is totally normal to just not use one direction in a given system, we
> > don't normally need to do anything special to handle things.  I'm a bit
> > confused as to what's different here and needs configuring?

> The IP does not provide an audio channel configured either as rx or tx.
> I agree, that in such case, the cpu driver does not generally need
> to worry about direction and there is nothing special required to handle it.

No, that's not what I'm saying - such hardware would be extremely
unusual.

> Here the IP provides 2 channels, 1 tx and 1 rx,  which may be active or 
> not. The driver has to know which channel is used, and if both channels
> have to be managed. The affected registers depend on selected channel. 

This sounds like essentially every audio controller out there.  The
overwhelming majority of controllers do exactly as you describe and have
both directions in the same IP, this really doesn't seem at all unusual.
Off the top of my head I can only think of one SoC family which combines
multiple IPs to do bidirectional audio (though I didn't check).

It really feels like there is something different here and I'm just
missing it.

> Moreover specific processing has to be performed if both channels are used.

Given that this case has to be supported anyway I'd be more inclined to
ask the question the other way around TBH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/24a83019/attachment.sig>
