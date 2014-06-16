From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jun 2014 09:15:39 +0100
Subject: [PATCH] Frees gate after if statement in clk-sunxi.c
In-Reply-To: <CAPDOMVimRry7XejNt9gdqLX4C64T7qsOwEBGvpYLDvxa2H5xuA@mail.gmail.com>
References: <1402769508-3821-1-git-send-email-xerofoify@gmail.com>
 <20140615203058.GA22265@lukather>
 <CAPDOMVj0JSp-ZfvAXkeTqHscKkhmp0ZttN5NVM+BYE_X+jWCcQ@mail.gmail.com>
 <CAPDOMVimRry7XejNt9gdqLX4C64T7qsOwEBGvpYLDvxa2H5xuA@mail.gmail.com>
Message-ID: <20140616081538.GV23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 15, 2014 at 11:31:41PM -0400, Nick Krause wrote:
> Seems the bug is fixed , don't worry about resent patch.
> Thanks Nick
> 
> On Sun, Jun 15, 2014 at 11:21 PM, Nick Krause <xerofoify@gmail.com> wrote:
> > @@ -42,6 +42,7 @@ static void __init sun4i_osc_clk_setup(struct
> > device_node *node)
> >         u32 rate;
> >
> >         if (of_property_read_u32(node, "clock-frequency", &rate))
> > +               kfree(gate);
> >                 return;

In any case, the kernel is not coded in Python.

C uses braces { } to enclose blocks of code, and does not care about
indentation - indentation is meaningless to C.  Python purely identifies
blocks of code by indentation alone.

Please take account of the programming language when creating patches.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
