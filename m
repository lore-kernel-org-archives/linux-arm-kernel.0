From: mahalakshmi.m@jasmin-infotech.com (mahalakshmi.m)
Date: Mon, 24 Sep 2012 19:22:42 +0530
Subject: i2c_transfer using 8bit register address
Message-ID: <006001cd9a5b$de7c1e30$9b745a90$@m@jasmin-infotech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

 

I am trying to send 8 bit register address using i2c_transfer.My code is as
follows.

 

static int My_Read(void *dev, u16 reg, u32 len,

                                 u16 *data, u32 endian)

{

        struct i2c_client *client = dev;

        struct i2c_msg msg[2];

        u16 block_data;

        int ret, icnt;

        unsigned char u8_RetryCnt = 0;

 

        msg[0].addr = client->addr;

        msg[0].flags = client->flags & I2C_M_TEN;

        msg[0].len = 2;

        msg[0].buf = (char *)&block_data;

 

        msg[1].addr = client->addr;

        msg[1].flags = client->flags & I2C_M_TEN;

        msg[1].flags |= I2C_M_RD;

        msg[1].len = len ;

        msg[1].buf = (char *)data;

 

                ret = i2c_transfer(client->adapter, msg, 2);

}

 

Where the register address " reg"  is for example 0x08. I want to read a
8bit register address 0x08. 

 

My confusion is that since  i2c_msg structure has u16 is it possible to send
0x08.Will I need to send as 0x0008.

 

struct i2c_msg {

  __u16 addr;

  __u16 flags;

#define I2C_M_TEN              0x0010

#define I2C_M_RD               0x0001

#define I2C_M_NOSTART          0x4000

#define I2C_M_REV_DIR_ADDR     0x2000

#define I2C_M_IGNORE_NAK       0x1000

#define I2C_M_NO_RD_ACK               0x0800

#define I2C_M_RECV_LEN         0x0400

  __u16 len;

  __u8 * buf;

};  

 

Kindly provide ur views.

 

Thanks & Regards,

Maha

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/9c6d1390/attachment-0001.html>
