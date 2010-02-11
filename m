From: tim_th@posti.tyyppi.org (Timo TH)
Date: Thu, 11 Feb 2010 09:40:59 +0200
Subject: AT91SAM9263 USB Serial hang?
Message-ID: <fc09324d1002102340o4444c8abve6d1d6bb5289d461@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anyone seen this kind of a problem?

Environment : ARM9 SAM9263ek, gprs modem on usb, (pppd 2.4.4)

With Linux 2.6.27.34 everything worked OK. (with at91-patches)
Upgraded to Linux 2.6.31.6 and now everything works upto point where
data connection should be made.
Something wrong with handling of DTR or DCD or what?



# modprobe ftdi_sio
usbcore: registered new interface driver usbserial
USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
USB Serial support registered for FTDI USB Serial Device
ftdi_sio 1-2.2:1.0: usb_probe_interface
ftdi_sio 1-2.2:1.0: usb_probe_interface - got id
ftdi_sio 1-2.2:1.0: FTDI USB Serial Device converter detected
usb 1-2.2: Detected FT2232C
usb 1-2.2: Number of endpoints 2
usb 1-2.2: Endpoint 1 MaxPacketSize 64
usb 1-2.2: Endpoint 2 MaxPacketSize 64
usb 1-2.2: Setting MaxPacketSize 64
usb 1-2.2: FTDI USB Serial Device converter now attached to ttyUSB0
ftdi_sio: v1.5.0:USB FTDI Serial Converters Driver

# microcom /dev/ttyUSB0
AT
OK
AT+CPIN=0000
OK
AT+CREG?
+CREG: 0,1
ATD*98#
//// No reply of any kind

With 2.6.27.34, everything above is same (except ftdi_sio is 1.4.3)
and there ATD gets reply
CONNECT

Strange detail, If instead of microcom doing
# cat < /dev/ttyUSB0 in one terminal, and just echo in the AT commands
in another terminal, then the cat displays CONNECT

But this is no help for my goal, since I'm trying to use pppd and it
only gets timeout to its ATD command.


Found some notes on the interwebs about reconnection problems in
2.6.31 but I couldnt connect those to this case.


Greatly appreciating any help and hints already..
- Timmy
