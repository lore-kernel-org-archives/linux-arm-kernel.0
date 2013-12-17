From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Dec 2013 10:46:17 +0000
Subject: [PATCH v3 11/36] mtd: st_spi_fsm: Search for preferred FSM
 message sequence configurations
In-Reply-To: <52B01FF2.8010801@st.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-12-git-send-email-lee.jones@linaro.org>
 <20131211010636.GH27149@ld-irv-0074.broadcom.com>
 <52B01FF2.8010801@st.com>
Message-ID: <20131217104617.GE19810@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +/* Search for preferred configuration based on available flags */
> >> +static struct seq_rw_config *
> >> +stfsm_search_seq_rw_configs(struct stfsm *fsm,
> >> +			    struct seq_rw_config cfgs[])
> >> +{
> >> +	struct seq_rw_config *config;
> >> +	int flags = fsm->info->flags;
> >> +
> >> +	for (config = cfgs; cfgs->cmd != 0; config++)
> > 
> > This becomes an infinite loop if you can't find a matching config. You
> > probably meant 'config->cmd != 0':
> 
> I will leave Lee to defend himself on this one ;-)

No defence necessary, I think Brian's correct.

NB: You might want to take a look at the 'dirty' implementation too. ;)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
