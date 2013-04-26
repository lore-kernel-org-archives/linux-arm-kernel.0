From: syin@broadcom.com (Sherman Yin)
Date: Fri, 26 Apr 2013 00:42:53 +0000
Subject: Adding a void * to pinctrl_pin_desc
Message-ID: <051069C10411E24D9749790C498526FA1BCF4FC6@SJEXCHMB12.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen and LinusW,

As I'm writing my pinctrl driver, I find myself creating an array to hold extra pin-specific information.  In the chip I'm working on, there is a pincfg register for each pin, but the fields of the register are slightly different for different pin types (eg. normal pins vs i2c pins).  I can simply create an array in my driver to hold this information, so I would have a list of PINCTRL_PIN(...) macros to define the pins, and another array to define the pin types - this works perfectly fine.  However, I thought this kind of per-pin data would fit nicely into the pinctrl_pin_desc structure.  Pin groups and pin functions are defined by the driver, so I thought it would be nice if the pin desc have this flexibility as well.  What do you think about expanding the struct to something like this:

struct pinctrl_pin_desc {
	unsigned number;
	const char *name;
	void * pin_data;
};

so that drivers can optionally use pin_data to hold other pin-specific information?  The down side is that with a void *, it may not be too useful if the pin-specific data is very different for each pin.  

Thanks,
Sherman
