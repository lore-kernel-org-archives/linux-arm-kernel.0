From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Nov 2018 09:25:58 -0800
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix possible use of uninitialized
 field
In-Reply-To: <20181107213031.21650-1-jmkrzyszt@gmail.com>
References: <20181107213031.21650-1-jmkrzyszt@gmail.com>
Message-ID: <20181108172558.GO56134@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [181107 13:28]:
> While playing with initialization order of modem device, it has been
> discovered that under some circumstances (early console init, I
> believe) its .pm() callback may be called before the
> uart_port->private_data pointer is initialized from
> plat_serial8250_port->private_data, resulting in NULL pointer
> dereference.  Fix it by checking for uninitialized pointer before using
> it in modem_pm().

Applying into omap-for-v4.20/fixes thanks.

Tony
