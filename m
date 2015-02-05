From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Feb 2015 12:08:29 +0000
Subject: [PATCH v5 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <CAJe_Zhf_WuRK2EE0Sj9ksXDDe5VA=DJ+H3eS4YRKpDZLdRRfow@mail.gmail.com>
References: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <3540319.u6RL7AO77m@wuerfel>
 <CAJe_ZhcXR4oaBKZx3n0ckCzXgbREoezUXjizJ09QXQVqEQ3G_g@mail.gmail.com>
 <2790199.44Rvt91EcZ@wuerfel>
 <CAJe_Zhf_WuRK2EE0Sj9ksXDDe5VA=DJ+H3eS4YRKpDZLdRRfow@mail.gmail.com>
Message-ID: <20150205120829.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 05:32:39PM +0530, Jassi Brar wrote:
> On Feb 5, 2015 5:13 PM, "Arnd Bergmann" <arnd@arndb.de> wrote:
> >
> > >
> > > I know typedef's are frowned upon, but how bad is the following option?
> > >        typedef void*  mbox_data_info
> > >        int mbox_send_message(struct mbox_chan *chan, mbox_data_info
> data);
> >
> > I don't see how that would help.
> >
> If it's abuse because the argument is a void*... What if we called it
> mbox_data_info?  To say platforms are free to pass data as a pointer or a
> value :)

Using a typedef really doesn't change anything.  If you read the kernel
coding style, you'll realise that typedefs are a reason to reject
patches - especially to use them in the way you are proposing.

Try the solution I suggested (which I notice was seemingly totally
ignored.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
