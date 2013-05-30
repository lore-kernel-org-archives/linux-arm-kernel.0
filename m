From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 30 May 2013 11:19:33 +0200
Subject: [PATCH 1/2] gpiolib: add gpio_export_with_name
In-Reply-To: <20121126135911.2F1D33E187C@localhost>
References: <20121121101259.GQ4398@game.jcrosoft.org>
 <1353492849-29397-1-git-send-email-plagnioj@jcrosoft.com>
 <20121126135911.2F1D33E187C@localhost>
Message-ID: <51A719A5.50906@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grant,

On 11/26/2012 02:59 PM, Grant Likely wrote:
> On Wed, 21 Nov 2012 11:14:08 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
>> allow to specify a name to an exported gpio
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>
> The gpio sysfs ABI is already horrible, racy, and unsafe. Really, we
> need a proper chrdev interface for controlling gpios. Sysfs is fine for
> poking around and experimenting, but we cannot provide any fine grained
> access control, locking or faster IO with the one-file-per-gpio sysfs
> model. So, no, I don't think this is a good idea to extend gpiolib in
> this way.
>

Would it make sense to provide only the DT binding to export a GPIO,
without changing the sysfs ABI? Even if work is progressing towards
having gpio-controlled reset pins [1], some boards still need GPIOs to
be exported to userspace for other functionalities.

Regards,

Florian

[1] http://article.gmane.org/gmane.linux.power-management.general/31364
