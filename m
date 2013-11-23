From: sre@ring0.de (Sebastian Reichel)
Date: Sat, 23 Nov 2013 22:09:13 +0100
Subject: N900 board code in 3.14
In-Reply-To: <CABxcv==b-Nj4ADT+qN9qLC8bL5raqkRkaLkGG0cMNrZV8njhDg@mail.gmail.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <20131116120508.GA22335@earth.universe>
 <20131116141226.GD10317@atomide.com>
 <20131116155031.GA5104@earth.universe>
 <20131121185844.GA10023@atomide.com>
 <20131121235111.GC9772@earth.universe>
 <CABxcv==b-Nj4ADT+qN9qLC8bL5raqkRkaLkGG0cMNrZV8njhDg@mail.gmail.com>
Message-ID: <20131123210912.GA29088@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 22, 2013 at 11:41:27AM +0100, Javier Martinez Canillas wrote:
> I dropped that patch from my series and posted a v2 that just name the
> VPLL2 regulator as vdds_dsi [1]. That way will be safer for Tony and
> Benoit to take this series as a fix for the -rc cycle since the
> changes are contained within IGEP boards DTS.

I know, but the patch serves as example for me :)

> > My suggestion would be to add something like this pseudocode to
> > omapdss:
> >
> > if(board_is_n900_dt()) {
> >     vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "V28");
> > }
> >
> > The problem is, that we do not want to name the regulator
> > "vdds_dsi", since it's not used exclusivly for omapdss.
> >
> > In the future it can get the regulator via phandle of course.
> 
> For what is worth I think that your suggestion is a good workaround.
> Please just add a comment specifying that it is a hack and that we
> have to get rid of these once the DSS DT bindings land on mainline and
> we can use a phandle to get the regulator.

I just sent a patchset, that adds DT panel support for N900.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131123/c3c30061/attachment.sig>
