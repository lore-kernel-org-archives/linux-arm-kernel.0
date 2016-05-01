From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun,  1 May 2016 14:49:15 +0200
Subject: [PATCH] VSOCK: constify vsock_transport structure
Message-ID: <1462106955-22131-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vsock_transport structure is never modified, so declare it as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 net/vmw_vsock/vmci_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 5621473..4120b7a 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -2051,7 +2051,7 @@ static u32 vmci_transport_get_local_cid(void)
 	return vmci_get_context_id();
 }
 
-static struct vsock_transport vmci_transport = {
+static const struct vsock_transport vmci_transport = {
 	.init = vmci_transport_socket_init,
 	.destruct = vmci_transport_destruct,
 	.release = vmci_transport_release,
