From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Oct 2010 11:29:35 -0200
Subject: [PATCH v2 1/1] mx35pdk: add debug board support
In-Reply-To: <AANLkTin1Y8u9NEUEtp7r0=Bx8Gbq-d5KE2koKZREQ5jz@mail.gmail.com>
References: <1287567283-19488-1-git-send-email-jgq516@gmail.com>
	<AANLkTin1Y8u9NEUEtp7r0=Bx8Gbq-d5KE2koKZREQ5jz@mail.gmail.com>
Message-ID: <AANLkTimkcvdMP83a8Z_1Scz435v6nnsHfn2bZt3-o8Wo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 11:17 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Xiao.
>
> On Wed, Oct 20, 2010 at 7:34 AM, ?<jgq516@gmail.com> wrote:
> ...
>> ? ? ? ?mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
>> +
>> + ? ? ? if (mxc_expio_init(MX35_CS5_BASE_ADDR, EXPIO_PARENT_INT))
>> + ? ? ? ? ? ? ? pr_warn("Init of the debugboard failed, all "
>> + ? ? ? ? ? ? ? ? ? ? ? "devices on the board are unusable.\n");
>
> ?' if (!mxc_expio_init' ?should be used here as I mentioned previously.
>
> mxc_expio_init returns 0 if succesful.


Ops, sorry.  'if (mxc_expio_init'  check is correct.

So I think the only thing you need to address in v3 is the comment from Baruch.

Thanks,

Fabio Estevam
