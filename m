From: marcio.lima54@gmail.com (Marcio Lima)
Date: Fri, 24 May 2013 14:35:24 -0300
Subject: Linux 2.6.39.4 in a AT91SAM9M10G45-EK 10 Mbytes dma buffer
 allocatiion
In-Reply-To: <20130524171924.GI24476@game.jcrosoft.org>
References: <CDC4E028.D8BC%marcio@netopen.com.br>
 <28C11E1EA5C742E9834AC24685367AB5@nete52c00369ab>
 <20130524171924.GI24476@game.jcrosoft.org>
Message-ID: <B4BA7F79-E9E2-426C-9E7B-06E95A7E533C@netopen.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Jean

the image takes 10 Mbytes to be stored!

Regards
Marcio

Enviado via iPhone

Em 24/05/2013, ?s 14:19, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> escreveu:

> On 09:35 Fri 24 May     , Marcio Campos de Lima wrote:
>> 
>> 
>> 
>>    
>> Hi
>> I am running Linux 2.6.39.4 in a AT91SAM9M10G45-EK platfarm. I need to
>> allocate 10 Mbytes dma buffer to capture an image from a CMOS sensor. The
>> board has 128Mbytes of total memory and 110 Mbytes of free memory. Can
>> anybody help me?
>> Thanks
>> MArcio
> 
> 10MiB? why that much?
> 
> you can not allowcate thar much on dma_alloc_coherent you need to use CMA
> 
> Best Regards,
> J.
>> 
>> at mm/page_alloc.c:2033 __alloc_pages_nodemask+0x140/0x5f8)
>> ht      = 19Modules linked
>> in:44;                                               
>>                                                                             
>>     
>> fmt.fmt.pix.[] (unwind_backtrace+0x0/0xe4) from [] (warn_sl)
>> pixelformat [] (warn_slowpath_common+0x4c/0x64) from [] (wa)
>> =30314742;                                                                  
>>     
>> f[] (warn_slowpath_null+0x18/0x1c) from [] (__alloc_pages_n)
>> mt.fmt.pix.fiel[] (__alloc_pages_nodemask+0x140/0x5f8) from [d       =
>> c72b2[] (__dma_alloc+0x94/0x2d8) from [] (dma_all)
>> cc8                                                                         
>>     
>> MARCIO[] (dma_alloc_coherent+0x54/0x60) from [] (vb2_dma_co)
>> : init_mmap: i[] (vb2_dma_contig_alloc+0x38/0xb4) from [] ()
>> nit                                                                         
>>     
>> [] (vb2_reqbufs+0x3b4/0x750) from [] (soc_camera_reqbufs+0x)
>> [] (soc_camera_reqbufs+0xbc/0x134) from [] (__video_do_ioct)
>> [] (__video_do_ioctl+0x1de0/0x4a24) from [] (video_usercopy)
>> [] (video_usercopy+0x358/0x48c) from [] (v4l2_ioctl+0x68/0x)
>> [] (v4l2_ioctl+0x68/0x114) from [] (vfs_ioctl+0x20/0x3c)    
>> [] (vfs_ioctl+0x20/0x3c) from [] (do_vfs_ioctl+0x520/0x578) 
>> [] (do_vfs_ioctl+0x520/0x578) from [] (sys_ioctl+0x34/0x54) 
>> [] (sys_ioctl+0x34/0x54) from [] (ret_fast_syscall+0x0/0x2c)
>> ---[ end trace acfd933d374f6f12
>> ]---                                            
>> atmel_isi atmel_isi.0: dma_alloc_coherent of size 10077696
>> failed               
>> MARCIO: __vb2_queue_alloc
>> ret=-12                                               
>> MARCIO: __vb2_queue_alloc
>> q->num_buffers=0                                      
>> MARCIO: vb2_reqbufs req->count=2 ret=0
>> num_buffers=1                            
>> MARCIO: vb2_reqbufs req->count=2 num_buffers=1
>> ret=0                            
>> MARCIO:vb2_reqbufs soc_camera_reqbufs ret=-12 icd->vb2_vidq=1 
>> p=1              
>> MARCIO:soc_camera_reqbufs
>> ret=-12                                               
>> VIDIOC_REQBUFS error 12, Out of memory
>>  
>>  
>>  
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
