From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Feb 2015 12:43:09 +0100
Subject: [PATCH v5 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <CAJe_ZhcXR4oaBKZx3n0ckCzXgbREoezUXjizJ09QXQVqEQ3G_g@mail.gmail.com>
References: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <3540319.u6RL7AO77m@wuerfel>
 <CAJe_ZhcXR4oaBKZx3n0ckCzXgbREoezUXjizJ09QXQVqEQ3G_g@mail.gmail.com>
Message-ID: <2790199.44Rvt91EcZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 February 2015 10:38:16 Jassi Brar wrote:
> Passing pointer to a structure on stack will be automatically punished
> as a random crash/behavior.
> We just need to make sure no client passes a value directly in 'void
> *data', right?

Yes.

> 
> I know typedef's are frowned upon, but how bad is the following option?
>        typedef void*  mbox_data_info
>        int mbox_send_message(struct mbox_chan *chan, mbox_data_info data);

I don't see how that would help. I believe typedefs for pointer types
are particularly bad because they hide what is going on. If we want to
enforce the use of pointers to point to data, having the pointer in 
the function prototype should be enough as a hint to driver developers ;-)

	Arnd
