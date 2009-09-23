From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Wed, 23 Sep 2009 05:36:33 -0500
Subject: platform data for the s3c-adc or hardcoded delay?
In-Reply-To: <2accc2ff0909230332y6bf565e0kc33a0ef8d8072451@mail.gmail.com>
References: <2accc2ff0909230332y6bf565e0kc33a0ef8d8072451@mail.gmail.com>
Message-ID: <2accc2ff0909230336m173f0b0fqc1e1c08be448b648@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Ben, sorry for sending 2 copies. I used the old list address... I'd
better go to sleep now.).


We had this for the touchscreen but it doesn't make sense now that the
driver has been converted to use the s3c-adc API.

const static struct s3c_ts_platdata gta02_ts_cfg = {
? ? ? .delay = 10000,
? ? ? .presc = 0xff, /* Slow as we can go. */
};

Without this delay the TS doesn't work for us:

Now I see two options:

1) Hardcode the delay in plat-s3c24xx/adc.c (As it's done in [1]).
2) Submit patches adding s3c_adc_platdata.

What do I do?

I also would like to know if we rule out the possibility of
delay/presc depending on the current s3c_adc_client.

[1] http://lists.openmoko.org/pipermail/openmoko-kernel/2009-September/010550.html
