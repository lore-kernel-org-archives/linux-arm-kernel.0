From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 24 Jun 2015 13:02:25 +0200
Subject: [PATCH 3/7] [media] use CONFIG_PM_SLEEP for suspend/resume
In-Reply-To: <565e229d31527f166090d0368a3c348755838899.1435142906.git.mchehab@osg.samsung.com>
References: <dd7a2acf5b7da9449988a99fe671349b3e5ec593.1435142906.git.mchehab@osg.samsung.com>
 <565e229d31527f166090d0368a3c348755838899.1435142906.git.mchehab@osg.samsung.com>
Message-ID: <558A8E41.1060104@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/24/2015 12:49 PM, Mauro Carvalho Chehab wrote:
> Using CONFIG_PM_SLEEP suppress the warnings when the driver is
> compiled without PM sleep functions:
>
> drivers/media/rc/st_rc.c:338:12: warning: ?st_rc_suspend? defined but not used [-Wunused-function]
> drivers/media/rc/st_rc.c:359:12: warning: ?st_rc_resume? defined but not used [-Wunused-function]
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>
> diff --git a/drivers/media/rc/st_rc.c b/drivers/media/rc/st_rc.c
> index 979b40561b3a..37d040158dff 100644
> --- a/drivers/media/rc/st_rc.c
> +++ b/drivers/media/rc/st_rc.c
> @@ -334,7 +334,7 @@ err:
>   	return ret;
>   }
>   
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>   static int st_rc_suspend(struct device *dev)
>   {
>   	struct st_rc_device *rc_dev = dev_get_drvdata(dev);
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
