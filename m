From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Fri, 23 Jan 2015 01:54:24 +0100
Subject: [PATCHv5 2/2] INPUT: Introduce generic trigger/LED pairs to
 input LEDs
In-Reply-To: <4596566.1GHUcIZaFc@dtor-glaptop>
References: <20141226232116.GA5069@type> <1756449.aIckN0M451@dtor-glaptop>
 <20150123004429.GD3123@type.youpi.perso.aquilenet.fr>
 <4596566.1GHUcIZaFc@dtor-glaptop>
Message-ID: <20150123005424.GA2869@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Torokhov, le Thu 22 Jan 2015 16:51:16 -0800, a ?crit :
> No. Please take a look at other users of platform data. Platform is the box we 
> are running on, not parent device. Platform data is supposed to be constant,
> not changing between driver runs.

Ok, well, then we can just use to_input_dev(cdev->dev->parent); to
access the input_dev from the led_classdev cdev.

Samuel
