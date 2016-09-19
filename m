From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 19 Sep 2016 17:15:12 +0200
Subject: [PATCH] ASoC: samsung: make audio interface/controller explicitly
In-Reply-To: <30C748BE-359C-4212-96D3-C2A71E1094C3@soulik.info>
References: <1474207751-9804-1-git-send-email-ayaka@soulik.info>
 <1474207751-9804-2-git-send-email-ayaka@soulik.info>
 <20160918144247.GA11009@kozik-book>
 <1bc1a3db-8120-a2ae-0f55-a5c1bb154dc6@soulik.info>
 <20160918180938.GA19279@kozik-book>
 <30C748BE-359C-4212-96D3-C2A71E1094C3@soulik.info>
Message-ID: <20160919151512.GA2012@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 09:21:54AM +0800, Ayaka wrote:
> 
> 
> ??? iPad ??
> 
> > Krzysztof Kozlowski <krzk@kernel.org> ? 2016?9?19? ??2:09 ???
> > 
> >> On Sun, Sep 18, 2016 at 11:12:34PM +0800, ayaka wrote:
> >> 
> >> 
> >>> On 09/18/2016 10:42 PM, Krzysztof Kozlowski wrote:
> >>>> On Sun, Sep 18, 2016 at 10:09:11PM +0800, Randy Li wrote:
> >>>> It is simple sound card time, we could assign different codec
> >>>> to a interface without making a specific driver for it.
> >>> The description does not convince me and I do not see an example using
> >>> this. Could you provide one?
> >> Sorry, the board TOPEET iTop 4412 for exynos 4412 I posted supported codec
> >> with I2S interface using the simple sound card. Anyway, it is no harm to
> >> make them explicitly right?
> > 
> > kbuild gave you the answer...
> Not sure how comes, even time I sent patches to you, I at lease build and run it once.

Building only one ARM config may be sufficient for trivial changes but
for more complex stuff (especially when dealing with Kconfig) needs more
build coverage. 

On Ubuntu you can easily cross compile for x86, x86_64,
arm, arm64 and powerpc. You can also use this cross-compiler collection:
https://www.kernel.org/pub/tools/crosstool


> > 
> >> Or I have to enabled those codec support for
> >> SMDK, which is not needed for the other board.
> > 
> > If I understand correctly, the i2s/pcm etc are still needed but not
> > built in config choosing only simple-audio-card? I tried now such
> > configuration on Odroid XU and indeed the audio is missing.
> > 
> > The patch looks like needed but:
> > 1. You need to describe the rationale in commit message, why it is
> > needed.
> Sorry about English.
> > 2. You need to fix it... kbuild pointed build issues.
> I would check that.
> > 
> > Other solution would be to add a user-selectable option for generic
> > sound on Samsung using simple audio card. The option would then select
> > appropriate SND_SAMSUNG* options, just like specific drivers do. I see
> > that sh does like this. Personally this approach seems simpler to me -
> > the defconfig could just choose this generic sound instead of many
> > SND_SAMSUNG_* sub-options.
> I would just what  Freescale did. It included those options entries in a sub-menu.
> I don't those options should be bound either, as a board may only use one of interface or controller(like TOPEET iTOP would only use i2s. No place for SPDIF, AC97 nor PCM.)

OK, sounds good for me. Thanks for explanation.


Best regards,
Krzysztof
