From: rozmanro@gmail.com (Roman Rozman)
Date: Thu, 29 Nov 2018 12:20:48 +0200
Subject: I2c eeprom file missing - SFP module
Message-ID: <CAEHvULmcFk5Z3kLRY-MF6vRVNms9q91X8k3MCq7aLXC4SRgyXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I have some linux kernel & SFP/I2C driver issue.
I am using a buildroot linux kernel for an embedded board.

I need to be able to read the eeprom file of the SFP
i2c device:/sys/class/i2c-adapter/i2c-1/1-0050/eeprom


1. working case:

When SFP module is inserted in my development unit board from the
start (before the kernel loads up) then when startup completed i can
see and read the eeprom file in the path:
/sys/class/i2c-adapter/i2c-1/1-0050/eeprom

kernel prints on startup shows the i2c device scan result:

i2c /dev entires driver
at24 - 1-0050: 256 byte 24c02 EEPROM, writable, 1 bytes/write
at24 - 1-0052: 3278 byte 24c256 EEPROM, writable, 1 bytes/write


2. not working case:

If there is no SFP module inserted on startup,and kernel completes the
boot procces, then when i'm inserting the SFP module in,i observe that
the path:
/sys/class/i2c-adapter/i2c-1/1-0050/ DOESN'T include the eeprom file.

the folder exists & includes:
modalias,name,of_node,power,subsystem,ueventbut no eeprom file.

The device tree part of the sfp-eeprom code:

&i2c0 {
 ...
  sfp_eeprom at 50 {
 compatible = "at,24c02";
 reg = 0x50 ;
 };


I expect the SFP driver to be responsible for the trigger that should
happen once the SFP module is inserted, and should trigger the i2c
devices scan which will result in creation of eeprom file.

Would like to ask you what am i missing ? some binding code from sfp
driver to trigger the i2c scan or something?

Thanks in advance,
Roman.
