From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Oct 2016 15:16:03 +0200
Subject: [PATCH 06/14] ASoC: Add sun8i digital audio codec
In-Reply-To: <20161004130727.srmaielkvd2z5k3s@sirena.org.uk>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004144008.0d07d18c@free-electrons.com>
 <20161004130727.srmaielkvd2z5k3s@sirena.org.uk>
Message-ID: <20161004151603.38aac5b2@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 4 Oct 2016 15:07:27 +0200, Mark Brown wrote:

> > /*
> >  * ...
> >  */  
> 
> I don't care, IIRC that's something from CodingStyle which checkpatch
> moans about.

Correct. The

/* ..
 * ..
 */

style is mandatory for net/ and crypto code, but not in the rest of the
kernel.

> > I'm probably missing something, but in the sun4i-codec.c driver, those
> > fields are initialized directly in the snd_soc_codec_driver structure,
> > not in the .component_driver sub-structure.  
> 
> We're in the process of pushing everything out to component level, this
> update should be made in the old code if it's not happened already.

OK.

> > > +	if (clk_prepare_enable(scodec->clk_module))
> > > +		pr_err("err:open failed;\n");  
> 
> > Grr, pr_err, not good. Plus you want to return with an error from the
> > probe() function.  
> 
> Also when printing an error message use dev_err().

That's why I said "Grr, pr_err, not good" :)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
