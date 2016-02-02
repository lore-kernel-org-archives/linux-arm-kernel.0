From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 2 Feb 2016 02:26:29 +0000
Subject: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <CABxcv=nJsWEv9KW-5iPpUnyN8ZVpx6CV07gBRaLNWqd644YOqQ@mail.gmail.com>
References: <1453863463-30515-1-git-send-email-wenyou.yang@atmel.com>
 <1453863463-30515-2-git-send-email-wenyou.yang@atmel.com>
 <20160129001603.GM4130@sirena.org.uk>
 <B256D81BAE5131468A838E5D7A243641D63FBF8B@penmbx01>
 <20160129113518.GQ4130@sirena.org.uk>
 <CABxcv=kNKmgRytxB5ppawrAvC-GDRhV4T_UUGvpHgKp9+BsUmQ@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A243641D63FE2C7@penmbx01>
 <CABxcv=nJsWEv9KW-5iPpUnyN8ZVpx6CV07gBRaLNWqd644YOqQ@mail.gmail.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641D6400956@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

> -----Original Message-----
> From: Javier Martinez Canillas [mailto:javier at dowhile0.org]
> Sent: 2016?2?1? 21:15
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Mark Brown <broonie@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>;
> Rob Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Ian
> Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>;
> Krzysztof Kozlowski <k.kozlowski@samsung.com>; Lee Jones
> <lee.jones@linaro.org>; Peter Korsgaard <jacmet@gmail.com>; Ferre, Nicolas
> <Nicolas.FERRE@atmel.com>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org
> Subject: Re: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
> ACT8945A
> 
> Hello Wenyou,
> 
> [snip]
> 
> >> >
> >> > If then device is not being loaded from the DT (and it shouldn't
> >> > be, the device looks like it should be instantiated directly by the
> >> > MFD as it can't exist separately to that MFD) an OF table will do nothing.
> >>
> >> Then he should remove the .of_compatible from the MFD cell definition.
> >
> > I tried it,
> >
> > But if removed this .of_compatible, and reserved the OF table.
> 
> What we said is that you should remove both the mfd cell .of_compatible field and
> the OF table. Of course removing one but leaving the other is not correct.

I am confused :)

> 
> > the &pdev->dev->of_node is NULL, the driver fails to get the
> > configuration value from DT,
> >
> 
> I see, you mean that you are not able to lookup the "active-semi,vsel-high"
> property.

No only this property,

The regulator init_datas are also not gotten from DT due to the &pdev->dev->of_node is NULL.

> 
> > It seems the OF table still doesn't work. Where is wrong?
> >
> 
> I think the problem is with your DT binding. You have a PMIC dev node with
> compatible "active-semi,act8945a" that has a child node with compatible "active-
> semi,act8945a-regulator" which in turn has the "regulators" node.
> 
> I believe what Mark says is that there shouldn't be a compatible and node for the
> regulators IC since is part of the PMIC. IOW, you can't have it as a standalone
> node in the DTS.
> 
> > Could you help give some suggestion?
> >
> 
> I would just remove the "active-semi,act8945a-regulator" node and make "active-
> semi,vsel-high" a property of the "active-semi,act8945a" node.
> That way you can remove the mfd cell .of_compatible and OF table in the
> regulator driver and read the "active-semi,vsel-high" using the platform device's
> parent of_node.
> 
> But it's better if you wait for Mark's opinions before re-spining your patches.

All right.

> 
> Best regards,
> Javier

Thanks 


Best Regards,
Wenyou Yang
