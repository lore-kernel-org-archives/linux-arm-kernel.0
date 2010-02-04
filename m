From: zgao6@marvell.com (Zhangfei Gao)
Date: Fri, 5 Feb 2010 05:12:19 +0800
Subject: [PATCH] i2c: i2c_msg.len modify to __u32 type
Message-ID: <mailman.192.1265263457.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    int i2c_master_send(struct i2c_client *client,const char *buf ,int
count)
    {
        ~
        msg.len = count;
        ~
    }
    Parameter count would truncate from int to __u16

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
---
 include/linux/i2c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 57d41b0..4769ce9 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -491,7 +491,7 @@ struct i2c_msg {
 #define I2C_M_IGNORE_NAK    0x1000    /* if I2C_FUNC_PROTOCOL_MANGLING */
 #define I2C_M_NO_RD_ACK        0x0800    /* if I2C_FUNC_PROTOCOL_MANGLING
*/
 #define I2C_M_RECV_LEN        0x0400    /* length will be first received
byte */
-    __u16 len;        /* msg length                */
+    __u32 len;        /* msg length                */
     __u8 *buf;        /* pointer to msg data            */
 };

-- 
1.6.0.4

--0023545306445f932a047ec01a2c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, Jean<br><br><br>We found type of i2c_msg.len is __u16, while parameter =
count in i2c_master_send is int.<br>The mismatch will truncate count from i=
nt to u16.<br>For example we downloading firmware which is more than 64K (6=
4K+8) via i2c, i2c would transfer u16 (8 bytes) in fact.<br>
<br><br>From 69ec7599bf0fa28441281be1df76a2f573bb9127 Mon Sep 17 00:00:00 2=
001<br>From: Zhangfei Gao &lt;<a href=3D"mailto:zgao6@marvell.com">zgao6 at ma=
rvell.com</a>&gt;<br>Date: Fri, 5 Feb 2010 05:12:19 +0800<br>Subject: [PATC=
H] i2c: i2c_msg.len modify to __u32 type<br>
<br>=A0=A0=A0 int i2c_master_send(struct i2c_client *client,const char *buf=
 ,int count)<br>=A0=A0=A0 {<br>=A0=A0=A0 =A0=A0=A0 ~<br>=A0=A0=A0 =A0=A0=A0=
 msg.len =3D count;<br>=A0=A0=A0 =A0=A0=A0 ~<br>=A0=A0=A0 }<br>=A0=A0=A0 Pa=
rameter count would truncate from int to __u16<br><br>Signed-off-by: Zhangf=
ei Gao &lt;<a href=3D"mailto:zgao6@marvell.com">zgao6 at marvell.com</a>&gt;<b=
r>
---<br>=A0include/linux/i2c.h |=A0=A0=A0 2 +-<br>=A01 files changed, 1 inse=
rtions(+), 1 deletions(-)<br><br>diff --git a/include/linux/i2c.h b/include=
/linux/i2c.h<br>index 57d41b0..4769ce9 100644<br>--- a/include/linux/i2c.h<=
br>+++ b/include/linux/i2c.h<br>
@@ -491,7 +491,7 @@ struct i2c_msg {<br>=A0#define I2C_M_IGNORE_NAK=A0=A0=
=A0 0x1000=A0=A0=A0 /* if I2C_FUNC_PROTOCOL_MANGLING */<br>=A0#define I2C_M=
_NO_RD_ACK=A0=A0=A0 =A0=A0=A0 0x0800=A0=A0=A0 /* if I2C_FUNC_PROTOCOL_MANGL=
ING */<br>=A0#define I2C_M_RECV_LEN=A0=A0=A0 =A0=A0=A0 0x0400=A0=A0=A0 /* l=
ength will be first received byte */<br>
-=A0=A0=A0 __u16 len;=A0=A0=A0 =A0=A0=A0 /* msg length=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 */<br>+=A0=A0=A0 __u32 len;=A0=A0=A0 =A0=A0=A0 /* msg l=
ength=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 */<br>=A0=A0=A0=A0 __u8 *buf;=
=A0=A0=A0 =A0=A0=A0 /* pointer to msg data=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 */<=
br>=A0};<br>=A0<br>-- <br>1.6.0.4<br><br><br>

--0023545306445f932a047ec01a2c--
--0023545306445f933a047ec01a2e
Content-Type: application/octet-stream; 
	name="0001-i2c-i2c_msg.len-modify-to-__u32-type.patch"
Content-Disposition: attachment; 
	filename="0001-i2c-i2c_msg.len-modify-to-__u32-type.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g593soxg0

RnJvbSA2OWVjNzU5OWJmMGZhMjg0NDEyODFiZTFkZjc2YTJmNTczYmI5MTI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBGcmksIDUgRmViIDIwMTAgMDU6MTI6MTkgKzA4MDAKU3ViamVjdDogW1BBVENIXSBpMmM6IGky
Y19tc2cubGVuIG1vZGlmeSB0byBfX3UzMiB0eXBlCgoJaW50IGkyY19tYXN0ZXJfc2VuZChzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50LGNvbnN0IGNoYXIgKmJ1ZiAsaW50IGNvdW50KQoJewoJCX4K
CQltc2cubGVuID0gY291bnQ7CgkJfgoJfQoJUGFyYW1ldGVyIGNvdW50IHdvdWxkIHRydW5jYXRl
IGZyb20gaW50IHRvIF9fdTE2CgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1h
cnZlbGwuY29tPgotLS0KIGluY2x1ZGUvbGludXgvaTJjLmggfCAgICAyICstCiAxIGZpbGVzIGNo
YW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2kyYy5oIGIvaW5jbHVkZS9saW51eC9pMmMuaAppbmRleCA1N2Q0MWIwLi40NzY5
Y2U5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2kyYy5oCisrKyBiL2luY2x1ZGUvbGludXgv
aTJjLmgKQEAgLTQ5MSw3ICs0OTEsNyBAQCBzdHJ1Y3QgaTJjX21zZyB7CiAjZGVmaW5lIEkyQ19N
X0lHTk9SRV9OQUsJMHgxMDAwCS8qIGlmIEkyQ19GVU5DX1BST1RPQ09MX01BTkdMSU5HICovCiAj
ZGVmaW5lIEkyQ19NX05PX1JEX0FDSwkJMHgwODAwCS8qIGlmIEkyQ19GVU5DX1BST1RPQ09MX01B
TkdMSU5HICovCiAjZGVmaW5lIEkyQ19NX1JFQ1ZfTEVOCQkweDA0MDAJLyogbGVuZ3RoIHdpbGwg
YmUgZmlyc3QgcmVjZWl2ZWQgYnl0ZSAqLwotCV9fdTE2IGxlbjsJCS8qIG1zZyBsZW5ndGgJCQkJ
Ki8KKwlfX3UzMiBsZW47CQkvKiBtc2cgbGVuZ3RoCQkJCSovCiAJX191OCAqYnVmOwkJLyogcG9p
bnRlciB0byBtc2cgZGF0YQkJCSovCiB9OwogCi0tIAoxLjYuMC40Cgo=
--0023545306445f933a047ec01a2e--
