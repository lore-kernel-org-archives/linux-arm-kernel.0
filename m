From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 13 Apr 2016 12:30:50 +0200
Subject: staging: fsl-mc: Convert to use platform_msi infrastrucutre
Message-ID: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale MC driver can't be build as module as it uses it's own
msi implementation. This patch set converts the driver to use platform_msi
infrastructure instead, so that we can build the driver as a module.

Apart from that we have to export some functions of the msi framework to
handle the domain.
