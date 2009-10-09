From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sat, 10 Oct 2009 00:12:24 +0400
Subject: [PATCH] irda/sa1100_ir: check return value of startup hook
In-Reply-To: <4ACF293C.7070803@ru.mvista.com>
References: <1255073153-24962-1-git-send-email-mad_soft@inbox.ru>
	<4ACF293C.7070803@ru.mvista.com>
Message-ID: <20091009201224.GA6208@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:14 Fri 09 Oct     , Sergei Shtylyov wrote:

[...]
> > -	if (si->pdata->startup)
> > -		si->pdata->startup(si->dev);
> > +	if (si->pdata->startup)	{
> > +		ret = si->pdata->startup(si->dev);
> > +		if (ret)
> > +			return ret;
> > +		}
> 
>     Overindented brace.
> 

Nice catch, thanks!

Updated patch in attachment.

-- 
Best regards,
Dmitry "MAD" Artamonow
