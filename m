From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 8 Dec 2014 08:11:48 +0100 (CET)
Subject: [PATCH 1/20] mtd: s3c2410: fix misspelling of current function
 in string
In-Reply-To: <CAFLxGvyiqxQ6U6p-A-JW8Nv8OvXFGsna93afUu-Gek0EV3gATA@mail.gmail.com>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
 <1417980062-25151-2-git-send-email-Julia.Lawall@lip6.fr>
 <CAFLxGvyiqxQ6U6p-A-JW8Nv8OvXFGsna93afUu-Gek0EV3gATA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1412080809400.2100@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> > index 35aef5e..0a9c41f 100644
> > --- a/drivers/mtd/nand/s3c2410.c
> > +++ b/drivers/mtd/nand/s3c2410.c
> > @@ -948,7 +948,7 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
> >
> >         cpu_type = platform_get_device_id(pdev)->driver_data;
> >
> > -       pr_debug("s3c2410_nand_probe(%p)\n", pdev);
> > +       pr_debug("%s(%p)\n", __func__, pdev);
> 
> I think we can drop the line completely.
> We have ftrace to trace function calls...

Should the "initialised ok" at the end of the function be remove as well?

Will it be confusing if this cleanup is done in this function, but not in 
others where it may be useful?  Perhaps s3c2410_nand_update_chip, for 
example?

julia
