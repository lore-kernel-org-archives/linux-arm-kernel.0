From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Nov 2009 01:32:41 -0500
Subject: [PATCH 05/10] mfd add irq support in 88pm860x
In-Reply-To: <20091114045659.GB4463@core.coreip.homeip.net>
References: <771cded00911130059q23c2bc97ja4509b7965f12eed@mail.gmail.com>
	<20091114045659.GB4463@core.coreip.homeip.net>
Message-ID: <771cded00911162232j7823699bl371cc2db8b0491ae@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 11:56 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Nov 13, 2009 at 03:59:21AM -0500, Haojian Zhuang wrote:
>> +
>> + ? ? mutex_lock(&chip->irq_lock);
>> + ? ? memset(chip->irq, 0, sizeof(struct pm860x_irq) * PM860X_NUM_IRQ);
>> + ? ? mutex_unlock(&chip->irq_lock);
>
> Why do you take lock here? Can anyone else be touching chip->irq at this
> point?
>
> --
> Dmitry
>

Updated.

Haojian
