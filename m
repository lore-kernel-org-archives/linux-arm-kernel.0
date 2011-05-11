From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 May 2011 10:03:04 +0200
Subject: [PATCH 5/9] at91: use structure to store the current soc
In-Reply-To: <BANLkTi=Zn3V8y=RgJGrmmDe+XxjXoJAgyw@mail.gmail.com>
References: <20110510162730.GA18929@game.jcrosoft.org>
	<1305045259-23066-5-git-send-email-plagnioj@jcrosoft.com>
	<4DC9B422.6070205@bluewatersys.com>
	<20110510234033.GB18929@game.jcrosoft.org>
	<4DC9DAAC.7060506@bluewatersys.com>
	<20110511032633.GG18929@game.jcrosoft.org>
	<4DCA0CB8.6060205@bluewatersys.com>
	<20110511041951.GD22009@game.jcrosoft.org>
	<BANLkTi=Zn3V8y=RgJGrmmDe+XxjXoJAgyw@mail.gmail.com>
Message-ID: <20110511080304.GA15489@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:30 Wed 11 May     , Andrew Victor wrote:
> hi,
> 
> >> You are missing the point. You have a function called soc_detect which
> >> returns void. It modifies a structure called at91_soc_data (this is not
> >> obvious from looking just at the function declaration) and returns
> > no sorry it's very clear
> 
> Even better would be:
>     struct at91_soc* at91_soc_detect();
> 
> It returns NULL if the AT91 is not detected or not supported in the
> kernel image.
no NULL we not allow to distingish both

the current implementation allow it already

> 
> 
> > at91 for the arch
> > soc_data data related to the soc
> >
> > you can see 1000 times of time in the kernel
> > gic_data
> > cpu_data etc....
> 
> If it's a shared with other ARM processors (ie, OMAP, PXA, etc), then soc_data.
> If it's only used on AT91 processors, then it gets prefixed with at91_.
this is already the case

Best Regards,
J.
