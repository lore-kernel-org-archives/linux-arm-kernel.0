From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 7 Dec 2012 10:36:43 +0000
Subject: [PATCH 0/6 v10] gpio: Add block GPIO
In-Reply-To: <1354830456-17590-1-git-send-email-stigge@antcom.de>
References: <1354830456-17590-1-git-send-email-stigge@antcom.de>
Message-ID: <20121207103643.34ca6dc5@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> * Device interface for userland access (alternative to sysfs)

Currently we can set different permissions on different GPIO lines. Your
driver change drives a truck through this facility.

I'm not sure there is an elegant way to snoop on the permissions set
on the sysfs gpio nodes and the driver also breaks managing GPIO rights
via smack/selinux/apparmor and assigning specific gpio lines to specific
pieces of user space code.

Alan
