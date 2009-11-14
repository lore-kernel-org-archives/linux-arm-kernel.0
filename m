From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 13 Nov 2009 20:56:59 -0800
Subject: [PATCH 05/10] mfd add irq support in 88pm860x
In-Reply-To: <771cded00911130059q23c2bc97ja4509b7965f12eed@mail.gmail.com>
References: <771cded00911130059q23c2bc97ja4509b7965f12eed@mail.gmail.com>
Message-ID: <20091114045659.GB4463@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 03:59:21AM -0500, Haojian Zhuang wrote:
> +
> +	mutex_lock(&chip->irq_lock);
> +	memset(chip->irq, 0, sizeof(struct pm860x_irq) * PM860X_NUM_IRQ);
> +	mutex_unlock(&chip->irq_lock);

Why do you take lock here? Can anyone else be touching chip->irq at this
point?

-- 
Dmitry
