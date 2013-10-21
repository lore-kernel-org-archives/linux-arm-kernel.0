From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 21 Oct 2013 08:59:27 -0700
Subject: [PATCHv4][ 1/4] Input: tsc2007: Add device tree support.
In-Reply-To: <1382363667-10341-1-git-send-email-denis@eukrea.com>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
Message-ID: <20131021155927.GB4255@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Mon, Oct 21, 2013 at 03:54:24PM +0200, Denis Carikli wrote:
>  
> +	if (ts->of)
> +		return tsc2007_get_pendown_state_dt(ts);
> +
>  	if (!ts->get_pendown_state)
>  		return true;

Instead of special casing "if (ts->of)" all over the place why don't you
set up the device structure as:

	if (<configuring_tsc2007_form_dt>)
		ts->get_pendown_state = tsc2007_get_pendown_state_dt;

and be done with it?

Thanks.

-- 
Dmitry
