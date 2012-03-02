From: zsadecki@itwatchdogs.com (Zach Sadecki)
Date: Fri, 2 Mar 2012 15:04:42 -0600
Subject: mxs auart driver problems
Message-ID: <4F5135EA.4080501@itwatchdogs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am having some problems with the mxs-auart driver in the mainline 
kernel.  If I use minicom to access the port (/dev/ttyAPP1) it seems to 
behave.  If I just send it some characters using 'echo -n " " > 
/dev/ttyAPP1'  it appears to work the first time, then if I repeat the 
same command it hangs until I kill it with ^C.

After some experimentation it seems that it only works if I'm actively 
reading characters out of it 'cat /dev/ttyAPP1' (in background or a 2nd 
terminal) and if I have turned off 'echo' using 'stty -F /dev/ttyAPP1 
-echo'.

Also, when it's in the hanging state, other ttys don't behave either 
(the AMBA serial console can't respawn the login process and I can't ssh 
into the system either).  Once I ^C the hanging 'echo' command 
immediately the console login respawns and ssh login works again.

Anybody else have this problem?  The Freescale kernel (driver with DMA) 
doesn't seem to have this issue.  Any ideas on what may be going on here?

Thanks,
   Zach
