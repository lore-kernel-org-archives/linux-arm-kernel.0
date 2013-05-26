From: davem@davemloft.net (David Miller)
Date: Sat, 25 May 2013 21:04:41 -0700 (PDT)
Subject: [PATCH 1/2] ARM: kirkwood: proper retain MAC address
 workaround on DT ethernet
In-Reply-To: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130525.210441.818472895703230779.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Wed, 22 May 2013 22:04:01 +0200

> +			memcpy((void *)p->value, reg, 6);

This cast is completely unnecessary, non-void to void pointer casts
are automatic.

If it is necessary, because p->value is const, then you are trying
to change something behind the OF layer's back and need to use
the appropriate interface to change the property contents.
