From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 26 Mar 2017 23:05:58 +0200
Subject: [PATCH v3 4/4] mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
In-Reply-To: <20170324143505.GK28518@lunn.ch>
References: <20170324141815.7252-1-ralph.sennhauser@gmail.com>
 <20170324141815.7252-5-ralph.sennhauser@gmail.com>
 <20170324143505.GK28518@lunn.ch>
Message-ID: <20170326230558.6b6c4ec6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Mar 2017 15:35:05 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +	pwm_fan {
> >  		/* SUNON HA4010V4-0000-C99 */
> > -		compatible = "gpio-fan";
> > -		gpios = <&gpio0 24 0>;
> >  
> > -		gpio-fan,speed-map = <0    0
> > -				      4500 1>;
> > +		compatible = "pwm-fan";
> > +		pwms = <&gpio0 24 4000 0>;  
> 
> Hi Ralph
> 
> I believe this last 0 is the flags parameter. Now that we have
> #pwm-cells = 1, i think this last 0 should be dropped.
> 
> 	  Andrew

Hi Andrew,

isn't the 4000 (period?) pwm-cell #2 and 0 (flags?) pwm-cell #3? I
actually expect "pwms = <&gpio0 24>;" here or "#pwm-cells = <2>;"

Ralph
