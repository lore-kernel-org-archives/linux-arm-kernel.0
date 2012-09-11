From: balbi@ti.com (Felipe Balbi)
Date: Tue, 11 Sep 2012 15:05:54 +0300
Subject: [PATCHv7 00/23]I2C big cleanup
In-Reply-To: <504F0FFA.2010200@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <504F0FFA.2010200@ti.com>
Message-ID: <20120911120552.GJ18907@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 11, 2012 at 03:48:34PM +0530, Shubhrajyoti wrote:
> On Tuesday 11 September 2012 03:11 PM, Shubhrajyoti D wrote:
> > Changes since v1:
> >        - removed tabification on patch 6/17
> >        - removed dev_err() which was introduced on patch 09/17
> > Changes since v2:
> >         - do not set full fifo depth in the RDR interrupt.
> >         - some changelog updates.
> >         - rebase to the Wolfram's tree.
> > Changes since v3:
> >         - Remove a redundant read of status register
> >         - Read the dev->buf_len variable instead of the register
> >         as the information of the remaining bytes is there.
> > Changes since v4:
> >         - Ack the arbitration lost.
> >         - Rebase to the i2c-embedded/for-next branch.
> > Changes since v5:
> >         - Rebase to latest mainline
> >         - Added some more cleanup patches so as have a consolidated series.
> > Changes since v6:
> >         - Fix comments on setting the pdev to NULL.
> >         - Trivial changelog update
> >
> > Previous discussions can be found here 
> > http://www.spinics.net/lists/linux-i2c/msg09482.html
> Also this gives better performance
> With the patches:
> 
>  Performance counter stats for '/build/i2c/bin/i2cdump -y -f 1 0x48
> b':        
>                                                                                
> 
>          78.796376 task-clock                #    0.453 CPUs
> utilized          
>                516 context-switches          #    0.007
> M/sec                  
>                  0 CPU-migrations            #    0.000
> K/sec                  
>                114 page-faults               #    0.001 M/sec  
> 
>       0.174011183 seconds time elapsed  
> 
> Without the patches
>  Performance counter stats for '/build/i2c/bin/i2cdump -y -f 1 0x48
> b':        
>                                                                                
> 
>         123.504640 task-clock                #    0.049 CPUs
> utilized          
>                337 context-switches          #    0.003
> M/sec                  
>                  0 CPU-migrations            #    0.000
> K/sec                  
>                144 page-faults               #    0.001
> M/sec                  
>                               
>                                                                                
> 
>        2.534424040 seconds time elapsed 
> 
> The auto suspend is probably the one  :-)

Awesome, I didn't go as far as checking performance counters :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/796b2d06/attachment-0001.sig>
