From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Tue, 12 Sep 2017 17:55:55 +0900
Subject: ThunderX BMC initialization failure
Message-ID: <087dcefa-1402-2d9f-da8d-18782df9eea3@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We're seeing below on our ThunderX

$ sudo systemctl start ipmi
Job for ipmi.service failed because the control process exited with 
error code. See "systemctl status ipmi.service" and "journalctl -xe" for 
details.
$ sudo journalctl -xe
...
-- Unit ipmi.service has begun starting up.
Sep 12 15:54:52 satsuma kernel: ipmi message handler version 39.2
Sep 12 15:54:53 satsuma kernel: IPMI System Interface driver.
Sep 12 15:54:53 satsuma kernel: ipmi_si: probing via SMBIOS
Sep 12 15:54:53 satsuma kernel: ipmi_si: Unable to find any System 
Interface(s)
Sep 12 15:54:53 satsuma openipmi-helper[2800]: Startup failed.
Sep 12 15:54:53 satsuma systemd[1]: ipmi.service: main process exited, 
code=exited, status=1/FAILURE
Sep 12 15:54:53 satsuma systemd[1]: Failed to start IPMI Driver.
-- Subject: Unit ipmi.service has failed
...

Is it caused by the IPMI driver that comes with CentOS 7 or the BIOS?

Thanks,

Itaru
