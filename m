From: lznuaa@gmail.com (Frank Li)
Date: Mon, 4 Feb 2013 10:22:23 +0800
Subject: [PATCH 1/1] net: fec: fix miss init spinlock
In-Reply-To: <20130202.230851.809969826800130930.davem@davemloft.net>
References: <1359708986-23634-1-git-send-email-Frank.Li@freescale.com>
 <20130202.230851.809969826800130930.davem@davemloft.net>
Message-ID: <CAHrpEqSLx-J-1SYC6OapqidY+U3acnTmNyOj8UrNRZwYZRXCoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/3 David Miller <davem@davemloft.net>:
> From: Frank Li <Frank.Li@freescale.com>
> Date: Fri, 1 Feb 2013 16:56:26 +0800
>
>> @@ -1607,6 +1607,7 @@ static int fec_enet_init(struct net_device *ndev)
>>       }
>>
>>       spin_lock_init(&fep->hw_lock);
>> +     spin_lock_init(&fep->tmreg_lock);
>
> This breaks the build, tmreg_lock is only present in certain
> configurations.

No, FEC have changed to check dramatically instead of static config.
You can look fec.h.  tmreg_lock is always defined.

        struct  napi_struct napi;

        struct ptp_clock *ptp_clock;
        struct ptp_clock_info ptp_caps;
        unsigned long last_overflow_check;
        spinlock_t tmreg_lock;
        struct cyclecounter cc;
        struct timecounter tc;
        int rx_hwtstamp_filter;
        u32 base_incval;
        u32 cycle_speed;
        int hwts_rx_en;
        int hwts_tx_en;
        struct timer_list time_keep;

best regards
Frank Li
