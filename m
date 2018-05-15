From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 15 May 2018 19:50:16 +0300
Subject: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
In-Reply-To: <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
 <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
Message-ID: <CAHp75VeM7_8+9QJjOypXaiBhpWP4B5KACdUQ-p3frbS3jPh=OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 7:48 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, May 15, 2018 at 12:07 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

>> +                       devm_kfree(dev, res);

devm_kfree() makes my eyes hurt.

> res = devm_kmemdump();

devm_kmemdup(&tmp...);

-- 
With Best Regards,
Andy Shevchenko
