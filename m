From: mmayer@broadcom.com (Markus Mayer)
Date: Tue, 13 Feb 2018 12:40:37 -0800
Subject: [PATCH 0/3] Update for the Broadcom STB DPFE driver
Message-ID: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series primarily introduces a new way of passing information from
the DCPU to the host CPU.

Previously, all communication was via the DCPU data RAM. This
communication mode is still supported. In addition, we now support
passing data via the message RAM. The driver will dynamically detect
which method to use upon receiving a reply.

The series also contains two fixes to the driver that have no direct
relation with the new communication feature.

Markus Mayer (3):
  memory: brcmstb: dpfe: properly mask vendor error bits
  memory: brcmstb: dpfe: fix type declaration of variable "ret"
  memory: brcmstb: dpfe: support new way of passing data from the DCPU

 drivers/memory/brcmstb_dpfe.c | 74 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 14 deletions(-)

-- 
2.7.4
