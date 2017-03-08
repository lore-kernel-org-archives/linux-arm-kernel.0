From: roszenrami@gmail.com (Rami Rosen)
Date: Wed, 8 Mar 2017 05:43:04 +0200
Subject: [PATCH v4 net-next 4/6] drivers: net: xgene-v2: Add base driver
In-Reply-To: <1488935325-13603-5-git-send-email-isubramanian@apm.com>
References: <1488935325-13603-1-git-send-email-isubramanian@apm.com>
 <1488935325-13603-5-git-send-email-isubramanian@apm.com>
Message-ID: <CAKoUArkOj-RvWZB-Gy6GC2C3yHFvsEGgoauQcAxYhBAurdjH0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
One minor comment:

The return type of xge_init_hw() should be changed to be void, as
the method xge_port_reset() always returns 0;  and also the return type
of xge_port_reset() should be changed to be void, it never fails; see
in [PATCH v4 net-next 3/6] drivers: net: xgene-v2: Add ethernet
hardware configuration.


+static int xge_init_hw(struct net_device *ndev)
+{
+       struct xge_pdata *pdata = netdev_priv(ndev);
+       int ret;
+
+       ret = xge_port_reset(ndev);
+       if (ret)
+               return ret;
+
+       xge_port_init(ndev);
+       pdata->nbufs = NUM_BUFS;
+
+       return 0;
+}

Regards,
Rami Rosen
