From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Thu, 24 Oct 2013 17:26:44 +0200
Subject: [PATCHv7][ 1/4] Input: tsc2007: Add device tree support.
In-Reply-To: <20131024151736.GE9044@ulmo.nvidia.com>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
 <20131024151736.GE9044@ulmo.nvidia.com>
Message-ID: <20131024172644.45816152@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Le Thu, 24 Oct 2013 17:17:37 +0200,
Thierry Reding <thierry.reding@gmail.com> a ?crit :
> > +- ti,max-rt: maximum pressure.
> > +- ti,fuzzy: specifies the absolute input fuzz value.
> > +  If set, it will permit noise in the data up to +- the value given to the fuzz
> > +  parameter, that is used to filter noise from the event stream.
> 
> Any reason why these can't be specified per axis? From my experience
> with this chip it can make sense to use different values for the
> different axes. Well, perhaps X and Y axes can share one fuzz factor,
> but the Z axis is sometimes different.
> 
> You also modify the driver to ignore the X and Z axes fuzz factor even
> for platform data where specifying all three separately was explicitly
> allowed. Have you verified that this doesn't cause any regressions?
> 
That was not intended, that's an error, we will fix that.

Thanks,
Eric
