From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 03 Jun 2013 11:46:11 +0100
Subject: [PATCH v1 2/2] ARM:prima2:move postcore_initcalls to init_machine.
In-Reply-To: <CAGsJ_4zTJamdH2-3vfqPSrOA+egST3rH_+2mPrhy6=1ZWJxnRg@mail.gmail.com>
References: <1369993439-24216-1-git-send-email-srinivas.kandagatla@st.com>
 <1369993517-24735-1-git-send-email-srinivas.kandagatla@st.com>
 <CAGsJ_4yu2MT5o7hbX67KPhrejS9D1BbPcship4zxtXs3G9tE-Q@mail.gmail.com>
 <51AC5A53.1090700@st.com>
 <CAGsJ_4zTJamdH2-3vfqPSrOA+egST3rH_+2mPrhy6=1ZWJxnRg@mail.gmail.com>
Message-ID: <51AC73F3.3040300@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/13 11:07, Barry Song wrote:
> i want to move sirfsoc_of_pwrc_init and sirfsoc_of_pwrc_init to
> sirfsoc_pm_init as only suspend entries need them. then the result is
> like:
> 
>  int __init sirfsoc_pm_init(void)
>  {
> +       sirfsoc_of_pwrc_init();
> +       sirfsoc_memc_init();
>         suspend_set_ops(&sirfsoc_pm_ops);
>         return 0;
>  }
> @@ -98,7 +103,7 @@ static const struct of_device_id pwrc_ids[] = {
>         {}
>  };

It looks good, and should fix the issue too.
