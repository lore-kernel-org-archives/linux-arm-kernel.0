From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 3 Dec 2014 12:15:18 +0100
Subject: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C spec
In-Reply-To: <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20141203111518.GB1039@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> + - rise-ns : Number of nanoseconds the signal takes to rise (t(r) in i2c spec).
> +	     If not specified this is assumed to be the max the spec allows
> +	     (1000 ns for standard mode, 300 ns for fast mode) which might
> +	     cause slightly slower communication.
> + - fall-ns : Number of nanoseconds the signal takes to fall (t(f) in the i2c0
> +	     spec).  If not specified this is assumed to be the max the spec
> +	     allows (300 ns) which might cause slightly slower communication.

We already have those bindings from the designware driver:

 - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
 - i2c-scl-falling-time : should contain the SCL falling time in nanoseconds.
 - i2c-sda-falling-time : should contain the SDA falling time in nanoseconds.

Can you reuse them? Or do you really need a specific rise-time property?
If so, please matche the style of the bindings above.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/f444f9f6/attachment.sig>
