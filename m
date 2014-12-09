From: marcel@holtmann.org (Marcel Holtmann)
Date: Tue, 9 Dec 2014 20:07:45 +0100
Subject: __hci_cmd_sync() not suitable for nokia h4p
In-Reply-To: <20141209190210.GA15641@amd>
References: <20141209190210.GA15641@amd>
Message-ID: <304050AD-DB11-4A2B-A1F7-8B1BBB5F04F0@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

> Major problem with Nokia H4P driver was, that it uses custom functions
> instead of __hci_cmd_sync().

the __hci_cmd_sync is for sending HCI commands and not low-level protocol transports like H:4 or similar. So you want to separate the actual transport of HCI from the firmware loading.

Regards

Marcel
