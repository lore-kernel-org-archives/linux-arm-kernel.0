From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 07 Mar 2016 14:54:27 +0100
Subject: [PATCH] Fix NULL ptr dereference in pci_bus_assign_domain_nr() on
 ARM
In-Reply-To: <20160304162737.GA1296@localhost> (Bjorn Helgaas's message of
 "Fri, 4 Mar 2016 10:27:37 -0600")
References: <m337sapw89.fsf@t19.piap.pl> <20160303173522.GA9189@localhost>
 <m38u1yojmq.fsf@t19.piap.pl> <20160304162737.GA1296@localhost>
Message-ID: <m3h9gimm0c.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn Helgaas <helgaas@kernel.org> writes:

>> At least CNS3xxx doesn't boot. I haven't verified a couple of others,
>> but they may be broken as well.
>
> Good, thanks.  Also (I should have asked this before), please include a
> "Fixes:" line so we know exactly when this broke and what stable kernels
> need the fix.

The problem started here:

Fixes: 8c7d14746abc ("ARM/PCI: Move to generic PCI domains")

It means the patch should be applicable starting with v4.0, and ...
indeed v4.0 with the patch boots correctly, while v4.0 without the patch
does not.

Thanks.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
