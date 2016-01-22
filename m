From: slash.tmp@free.fr (Mason)
Date: Fri, 22 Jan 2016 18:37:43 +0100
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
Message-ID: <56A268E7.7040004@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm hitting
Unhandled fault: page domain fault (0x81b) at 0x00e41008

which is related to CPU_SW_DOMAIN_PAN
commit a5e090acbf545c0a3b04080f8a488b17ec41fe02


I see that __copy_from_user() is now wrapped in
uaccess_save_and_enable ... uaccess_restore

I'm not using __copy_from_user() because I'm implementing block
copies with specific access size.

Can I just wrap my block copy functions in
uaccess_save_and_enable ... uaccess_restore
like __copy_from_user?

Regards.
