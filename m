From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Jan 2011 13:06:31 -0000
Subject: [PATCH] ARM: nommu: avoid mapping vectors page when !CONFIG_MMU
In-Reply-To: <4D2C4E05.7050608@snapgear.com>
References: <1294747337-18238-1-git-send-email-will.deacon@arm.com>
	<4D2C4E05.7050608@snapgear.com>
Message-ID: <000001cbb190$5e337a30$1a9a6e90$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

> > When running without an MMU, we do not need to install a mapping for the
> > vectors page. Attempting to do so causes a compile-time error because
> > install_special_mapping is not defined.
> >
> > This patch adds compile-time guards to the vector mapping functions
> > so that we can build nommu configurations once more.
> >
> > Cc: Greg Ungerer<gerg@uclinux.org>
> > Signed-off-by: Will Deacon<will.deacon@arm.com>
> 
> I hit this a couple of days ago too, looks good.
> 
> Acked-by: Greg Ungerer <gerg@uclinux.org>

Thanks. Submitted to Russell as 6619/1.

Will
