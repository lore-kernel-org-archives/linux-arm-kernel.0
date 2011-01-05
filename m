From: ben-i2c@fluff.org (Ben Dooks)
Date: Wed, 5 Jan 2011 12:17:31 +0000
Subject: [PATCH 1/6] i2c-pxa: move i2c_pxa_remove to __devexit instead
	of just __exit
In-Reply-To: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20110105121731.GG817@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 05:05:05AM +0300, Dmitry Eremin-Solenikov wrote:
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: linux-i2c at vger.kernel.org
> Cc: Ben Dooks <ben-linux@fluff.org>

Please write a reasonable commit message, a null or almost empty commit
message is simply unnaceptable. Please see the Documentation/SubmittingPatches
or ask more about how to write good commit messages.

Also, see Uwe's reply for a good example of how to write a commit message.

> -static int __exit i2c_pxa_remove(struct platform_device *dev)
> +static int __devexit i2c_pxa_remove(struct platform_device *dev)
>  {
>  	struct pxa_i2c *i2c = platform_get_drvdata(dev);
>  
> @@ -1169,7 +1169,7 @@ static const struct dev_pm_ops i2c_pxa_dev_pm_ops = {
>  
>  static struct platform_driver i2c_pxa_driver = {
>  	.probe		= i2c_pxa_probe,
> -	.remove		= __exit_p(i2c_pxa_remove),
> +	.remove		= __devexit_p(i2c_pxa_remove),
>  	.driver		= {
>  		.name	= "pxa2xx-i2c",
>  		.owner	= THIS_MODULE,

Right, I think this should fix any hotplug problems that you have.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
