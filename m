From: soni.trilok@gmail.com (Trilok Soni)
Date: Tue, 22 Dec 2009 18:14:14 +0530
Subject: [PATCH 1/2] gpio add interrupt support on pca953x
In-Reply-To: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
References: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
Message-ID: <5d5443650912220444h22500c95p45f7332300d070b7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +static void pca953x_irq_handler(unsigned int irq, struct irq_desc *desc)
> +{
> + ? ? ? struct pca953x_chip *chip = desc->handler_data;
> +
> + ? ? ? desc->chip->ack(irq);
> + ? ? ? schedule_work(&chip->irq_work);
> +}

Please use threaded IRQ support. Check request_threaded_irq API and I
think wm8350 driver under drivers/mfd/ for example in latest kernel.




-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
