From: carlo@caione.org (Carlo Caione)
Date: Tue, 24 May 2016 10:08:03 +0200
Subject: [PATCH v3 1/4] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <m2posco5k2.fsf@baylibre.com>
References: <1464021024-29380-1-git-send-email-carlo@caione.org>
 <1464021024-29380-2-git-send-email-carlo@caione.org>
 <m2posco5k2.fsf@baylibre.com>
Message-ID: <20160524080803.GB18935@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/16 13:58, Kevin Hilman wrote:

[...]
> > +	if (of_property_read_u32(np, "amlogic,sm-cmd-input-base", &cmd_in))
> > +		return -EINVAL;
> > +
> > +	if (of_property_read_u32(np, "amlogic,sm-cmd-output-base", &cmd_out))
> > +		return -EINVAL;
> > +
> > +	sm_phy_in_base = meson_sm_call(cmd_in, 0, 0, 0, 0, 0);
> 
> Should there be any error checking here?  Do we have any info on the
> return values here in case of error, or in case of missing firmware,
> etc.

We do not have any info on that but I can assume 0 is considered an
error as for other SMC calls. Fix in v4.

-- 
Carlo Caione
