From: troglobit@gmail.com (Troglobit)
Date: Tue, 24 Feb 2015 09:26:39 +0100 (CET)
Subject: [PATCH] pci-versatile.c: Update for API change in
 list_for_each_entry()
Message-ID: <alpine.DEB.2.10.1502240916240.26214@luthien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


In Linux 4.0-rc1 ARM Versatile PCI build fails to build due to what
appears to be an API update.  This patch is a very simple correction,
merely posted as a heads-up to the maintainers.  Hopefully a better
fix can be forwarded to Linus.

Signed-off-by: Joachim Nilsson <troglobit@gmail.com>

---
  drivers/pci/host/pci-versatile.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 1ec694a..464bf49 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -80,7 +80,7 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
  	if (err)
  		return err;

-	resource_list_for_each_entry(win, res, list) {
+	resource_list_for_each_entry(win, res) {
  		struct resource *parent, *res = win->res;

  		switch (resource_type(res)) {
-- 
1.9.1
