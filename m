From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Dec 2015 18:20:33 +0100
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move
 rockchip to use it
In-Reply-To: <20151223100534.GW960@e106497-lin.cambridge.arm.com>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <20151222173800.GU960@e106497-lin.cambridge.arm.com>
 <20151223103906.2aae53595345240d57d57b41@free.fr>
 <20151223100534.GW960@e106497-lin.cambridge.arm.com>
Message-ID: <20151223182033.a52356408b9a81e9497464e7@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Dec 2015 10:05:34 +0000
Liviu Dudau <Liviu.Dudau@arm.com> wrote:

> > What was the reason to keep the "ports" node instead of the device?
> 
> The function is an extract of common code sprinkled through a few DRM drivers,
> they all used port rather than port->parent.

Sorry for I could find such drivers. May you give me any pointer?

> Have a look at my v2 where I've introduced two compare functions and also
> modified the Rockchip compare_port() to use port->parent in the comparison. I
> guess that should solve your problem.

Keeping the port instead of the parent asks for more code, but,
especially, it also asks for changes in the component drivers because,
at bind time, in 'data', they get a port instead of the device.

You might say that this could be interesting for components with many
different masters (video and audio), but this could be solved adding
intermediate device nodes in the DT (ports).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
