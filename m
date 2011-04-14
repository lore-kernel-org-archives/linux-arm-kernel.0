From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 14 Apr 2011 14:56:38 +0530
Subject: [PATCH 6/6] da8xx: enable the use of the ICPFUNC in i2c-davinci
In-Reply-To: <BANLkTikskhqNk3NihqJ5kZhFqn1YpJEN9A@mail.gmail.com>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
	<f1ff3f2888725a1e03541e0be5c0880f0591aea2.1302031487.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB593024C8B3C9F@dbde02.ent.ti.com>
	<BANLkTikskhqNk3NihqJ5kZhFqn1YpJEN9A@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C960196@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, Apr 14, 2011 at 04:34:34, Mike Williamson wrote:

> > The I2C driver implements a default platform data
> > so it should actually be legal for a DA8x board to
> > pass NULL platform data. In that case this line
> > will crash. You should either check for pdata to
> > be NULL or just let each board choose whether it
> > needs recovery (I think the better option).
> >
> 
> I actually had a problem with using NULL for pdata with davinci I2C
> and had submitted a patch here that sort of fell on the floor.  The
> problem was that the i2c_davinci_calc_clk_dividers is using
> platform_data without a check as described above.  So at the moment
> using NULL doesn't really work, best as I can tell...
> 
> https://lkml.org/lkml/2010/9/4/119

Looking at this mail chain, it looks like Ben was actually OK
with your first submission and just wanted you to update the
patch description saying that dev->platform_data is accessed
later in the code and that is why it needs to be updated.

I liked your first attempt better and may be you should
try another submission with the patch description updated.

Thanks,
Sekhar
