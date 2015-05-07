From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 07 May 2015 19:01:36 +0200
Subject: [RFC] ARM/ARM64: KVM: Implement KVM_FLUSH_DCACHE_GPA ioctl
In-Reply-To: <CAGE1QJoEAg9tAM63MEbpLuqvY_ZwGrHPU1sqo=L_iByKrERUow@mail.gmail.com>
References: <1430817191-6231-1-git-send-email-j.fanguede@virtualopensystems.com>
 <20150506141249.GA6796@cbox>
 <CAGE1QJrabWWs0O1V-MpOxT_=1472TXb5rvJzJAJNfWH70x9pcg@mail.gmail.com>
 <20150507112027.GC25885@cbox>
 <CAGE1QJoyaGpuf=6Msa=xpm0pPGRkYWctcXGf=rwnha5o9Gm4bw@mail.gmail.com>
 <CAMJs5B9i9q8gJU93B09-uLMF6w1bTft-40DWPFUP6ky=SketSQ@mail.gmail.com>
 <CAGE1QJoEAg9tAM63MEbpLuqvY_ZwGrHPU1sqo=L_iByKrERUow@mail.gmail.com>
Message-ID: <554B9A70.6020309@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/05/2015 18:56, J?r?my Fangu?de wrote:
> USB devices fail with a timeout error, as if the communication between
> the kernel and the devices fail at a certain point:
> usb 1-1: device not accepting address 5, error -110
> usb usb1-port1: unable to enumerate USB device
> 
> e1000 fails when the userspace tries to use it, with these type of
> kernel messages:
> e1000 0000:00:02.0 eth0: Detected Tx Unit Hang
>   Tx Queue             <0>
>   TDH                  <d>
>   TDT                  <d>
>   next_to_use          <d>
>   next_to_clean        <9>
> buffer_info[next_to_clean]
>   time_stamp           <ffff9311>
>   next_to_watch        <a>
>   jiffies              <ffff956a>
>   next_to_watch.status <0>

Can you find out what memory attributes the guest is using for the
memory---and if it's uncached, why?

Paolo
