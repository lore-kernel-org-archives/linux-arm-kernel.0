From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Sep 2011 08:46:08 +0200
Subject: [PATCH] mach-integrator: fix VGA base regression
In-Reply-To: <4E64496E.1090000@gmail.com>
References: <1315172408-18957-1-git-send-email-linus.walleij@linaro.org>
	<4E64496E.1090000@gmail.com>
Message-ID: <CACRpkdYw4WCJ+kBm_FBH=H-vPKBUsb9DFToK0MN4F8t5T8Tc9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 5, 2011 at 6:00 AM, Rob Herring <robherring2@gmail.com> wrote:

>> @@ -154,6 +155,7 @@ static struct map_desc ap_io_desc[] __initdata = {
>> ?static void __init ap_map_io(void)
>> ?{
>> ? ? ? iotable_init(ap_io_desc, ARRAY_SIZE(ap_io_desc));
>> + ? ? vga_base = PCI_MEMORY_VADDR;
>> ?}
>> @@ -505,7 +504,6 @@ void __init pci_v3_preinit(void)
>>
>> ? ? ? pcibios_min_io = 0x6000;
>> ? ? ? pcibios_min_mem = 0x00100000;
>> - ? ? vga_base = PCI_MEMORY_VADDR;
>>
>> ? ? ? /*
>> ? ? ? ?* Hook in our fault handler for PCI errors
>
> Should the VGA memory really be accessed before PCI host is initialized?

I don' know, I don't know one bit about how PCI works and should
work, you tell me :-)

What I know is that without this patch the 3.1 rc does not boot on
Integrator.

Do you prefer that I revert your commit and wait with this thing
until we figured out why it breaks the Integrator instead?

Yours,
Linus Walleij
